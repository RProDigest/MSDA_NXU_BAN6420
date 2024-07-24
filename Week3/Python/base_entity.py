class BaseEntity:
    def __init__(self, entity_id, name):
        self._entity_id = entity_id
        self._name = name
        self._active = True
        print(f"{self.__class__.__name__} {self._name} (ID: {self._entity_id}) has been created and is currently active.")

    def suspend(self):
        if not self._active:
            raise ValueError(f"{self.__class__.__name__} is already suspended.")
        self._active = False
        print(f"{self.__class__.__name__} {self._name} (ID: {self._entity_id}) has been suspended.")

    def reactivate(self):
        if self._active:
            raise ValueError(f"{self.__class__.__name__} is already active.")
        self._active = True
        print(f"{self.__class__.__name__} {self._name} (ID: {self._entity_id}) has been reactivated.")

    def get_details(self):
        status = "Active" if self._active else "Suspended"
        details = {
            'ID': self._entity_id,
            'Name': self._name,
            'Status': status
        }
        print(f"{self.__class__.__name__} Details: {details}")
        return details

    @property
    def entity_id(self):
        return self._entity_id

    @property
    def name(self):
        return self._name

    @property
    def active(self):
        return self._active
